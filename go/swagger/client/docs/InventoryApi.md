# \InventoryApi

All URIs are relative to *https://app.rebuildeq.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**ListInventory**](InventoryApi.md#ListInventory) | **Get** /character/{characterId}/inventory | 


# **ListInventory**
> []Item ListInventory(ctx, characterId)


Get inventory of character

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ctx** | **context.Context** | context for logging, tracing, authentication, etc.
  **characterId** | **int32**| ID of Character | 

### Return type

[**[]Item**](Item.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

