# \NPCApi

All URIs are relative to *https://app.rebuildeq.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**GetNPC**](NPCApi.md#GetNPC) | **Get** /npc/{id} | 
[**GetNPCsByItem**](NPCApi.md#GetNPCsByItem) | **Get** /npc/search/item/{id} | 


# **GetNPC**
> Npc GetNPC(ctx, id)


Get information about a specific NPC

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ctx** | **context.Context** | context for logging, tracing, authentication, etc.
  **id** | **string**| ID of NPC | 

### Return type

[**Npc**](NPC.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **GetNPCsByItem**
> []Npc GetNPCsByItem(ctx, id)


Search for NPCs who drop provided item

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ctx** | **context.Context** | context for logging, tracing, authentication, etc.
  **id** | **string**| ID of Item | 

### Return type

[**[]Npc**](NPC.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

