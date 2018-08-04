// Copyright 2015 Apcera Inc. All rights reserved.

#include <string.h>
#include <assert.h>

#include "err.h"
#include "mem.h"
#include "buf.h"

static natsStatus
_init(natsBuffer *newBuf, char *data, int len, int capacity)
{
    natsBuffer *buf = newBuf;

    // Since we explicitly set all fields, no need for memset

    buf->doFree = false;

    if (data != NULL)
    {
        buf->data    = data;
        buf->ownData = false;
    }
    else
    {
        buf->data = (char*) NATS_MALLOC(capacity);
        if (buf->data == NULL)
            return nats_setDefaultError(NATS_NO_MEMORY);

        buf->ownData = true;
    }

    buf->pos      = buf->data + len;
    buf->len      = len;
    buf->capacity = capacity;

    return NATS_OK;
}

natsStatus
natsBuf_InitWithBackend(natsBuffer *newBuf, char *data, int len, int capacity)
{
    if (data == NULL)
        return NATS_INVALID_ARG;

    return _init(newBuf, data, len, capacity);
}

natsStatus
natsBuf_Init(natsBuffer *buf, int capacity)
{
    return _init(buf, NULL, 0, capacity);
}

static natsStatus
_newBuf(natsBuffer **newBuf, char *data, int len, int capacity)
{
    natsBuffer  *buf;

    buf = (natsBuffer*) NATS_MALLOC(sizeof(natsBuffer));
    if (buf == NULL)
        return nats_setDefaultError(NATS_NO_MEMORY);

    if (_init(buf, data, len, capacity) != NATS_OK)
    {
        NATS_FREE(buf);
        return NATS_UPDATE_ERR_STACK(NATS_NO_MEMORY);
    }

    buf->doFree = true;

    *newBuf = buf;

    return NATS_OK;
}

natsStatus
natsBuf_CreateWithBackend(natsBuffer **newBuf, char *data, int len, int capacity)
{
    natsStatus s;

    if (data == NULL)
        return nats_setDefaultError(NATS_INVALID_ARG);

    s = _newBuf(newBuf, data, len, capacity);

    return NATS_UPDATE_ERR_STACK(s);
}

natsStatus
natsBuf_Create(natsBuffer **newBuf, int capacity)
{
    natsStatus s = _newBuf(newBuf, NULL, 0, capacity);
    return NATS_UPDATE_ERR_STACK(s);
}

void
natsBuf_Reset(natsBuffer *buf)
{
    buf->len = 0;
    buf->pos = buf->data;
}

void
natsBuf_RewindTo(natsBuffer *buf, int newPosition)
{
    assert(newPosition < buf->capacity);

    buf->len = newPosition;
    buf->pos = buf->data + newPosition;
}


natsStatus
natsBuf_Expand(natsBuffer *buf, int newSize)
{
    int     offset   = (int) (buf->pos - buf->data);
    char    *newData = NULL;

    if (newSize <= buf->capacity)
        return nats_setDefaultError(NATS_INVALID_ARG);

    if (buf->ownData)
    {
        newData = NATS_REALLOC(buf->data, newSize);
        if (newData == NULL)
            return nats_setDefaultError(NATS_NO_MEMORY);
    }
    else
    {
        newData = NATS_MALLOC(newSize);
        if (newData == NULL)
            return nats_setDefaultError(NATS_NO_MEMORY);

        memcpy(newData, buf->data, buf->len);
        buf->ownData = true;
    }

    if (buf->data != newData)
    {
        buf->data = newData;
        buf->pos  = (char*) (buf->data + offset);
    }

    buf->capacity = newSize;

    return NATS_OK;
}

natsStatus
natsBuf_Append(natsBuffer *buf, const char* data, int dataLen)
{
    natsStatus  s = NATS_OK;
    int         n = buf->len + dataLen;

    // We could use int64_t and check for 0x7FFFFFFF, but keeping
    // all int is faster.
    if (n < 0)
        return nats_setDefaultError(NATS_NO_MEMORY);

    if (n > buf->capacity)
    {
        // Increase by 10%
        int extra = (int) (n * 0.1);
        int newSize;

        // Make sure that we have at least some bytes left after adding.
        newSize = (n + (extra < 64 ? 64 : extra));

        // Overrun.
        if (newSize < 0)
            return nats_setDefaultError(NATS_NO_MEMORY);

        s = natsBuf_Expand(buf, newSize);
    }

    if (s == NATS_OK)
    {
        memcpy(buf->pos, data, dataLen);
        buf->pos += dataLen;
        buf->len += dataLen;
    }

    return NATS_UPDATE_ERR_STACK(s);
}

natsStatus
natsBuf_AppendByte(natsBuffer *buf, char b)
{
    natsStatus  s = NATS_OK;
    int         c = buf->capacity;

    if (buf->len == c)
    {
        // Increase by 10%
        int extra = (int) (c * 0.1);
        int newSize;

        // Make sure that we have at least some bytes left after adding.
        newSize = (c + (extra < 64 ? 64 : extra));

        // Overrun.
        if (newSize < 0)
            return nats_setDefaultError(NATS_NO_MEMORY);

        s = natsBuf_Expand(buf, newSize);
    }

    if (s == NATS_OK)
    {
        *(buf->pos++) = b;
        buf->len++;
    }

    return NATS_UPDATE_ERR_STACK(s);
}

void
natsBuf_Consume(natsBuffer *buf, int n)
{
    int remaining;

    assert(n <= buf->len);

    remaining = buf->len - n;
    if (remaining > 0)
        memmove(buf->data, buf->data + n, remaining);

    buf->len = remaining;
    buf->pos = buf->data + remaining;
}

void
natsBuf_Destroy(natsBuffer *buf)
{
    if (buf == NULL)
        return;

    if (buf->ownData)
        NATS_FREE(buf->data);

    if (buf->doFree)
        NATS_FREE(buf);
    else
        memset(buf, 0, sizeof(natsBuffer));
}
