# \ZoneApi

All URIs are relative to *https://app.rebuildeq.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**GetZone**](ZoneApi.md#GetZone) | **Get** /zone/{zoneId}/detail | 
[**ListZoneChart**](ZoneApi.md#ListZoneChart) | **Get** /zone/chart | 
[**ListZoneSearch**](ZoneApi.md#ListZoneSearch) | **Get** /zone/search | 


# **GetZone**
> Zone GetZone(ctx, zoneId)


Get information about a specific Zone

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ctx** | **context.Context** | context for logging, tracing, authentication, etc.
  **zoneId** | **int32**| ID of Zone | 

### Return type

[**Zone**](Zone.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **ListZoneChart**
> ListZoneChart(ctx, )


Get a list of zone charts

### Required Parameters
This endpoint does not need any parameter.

### Return type

 (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **ListZoneSearch**
> []Zone ListZoneSearch(ctx, optional)


Search for zone

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ctx** | **context.Context** | context for logging, tracing, authentication, etc.
 **optional** | **map[string]interface{}** | optional parameters | nil if no parameters

### Optional Parameters
Optional parameters are passed through a map[string]interface{}.

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **query** | **string**| Zone details to search for | 

### Return type

[**[]Zone**](Zone.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

