# \InventoryApi

All URIs are relative to *https://app.rebuildeq.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**GetInventory**](InventoryApi.md#GetInventory) | **Get** /inventory/{id} | 


# **GetInventory**
> []Item GetInventory(ctx, id)


Get inventory of character

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ctx** | **context.Context** | context for logging, tracing, authentication, etc.
  **id** | **string**| ID of Character | 

### Return type

[**[]Item**](Item.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

