# \BuildApi

All URIs are relative to *https://app.rebuildeq.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**GetSpentBuildPoints**](BuildApi.md#GetSpentBuildPoints) | **Get** /builds/{id} | 
[**TrainBuildPoint**](BuildApi.md#TrainBuildPoint) | **Put** /build/{id} | 


# **GetSpentBuildPoints**
> BuildPoints GetSpentBuildPoints(ctx, id)


Get all trained build points

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ctx** | **context.Context** | context for logging, tracing, authentication, etc.
  **id** | **string**| ID of character | 

### Return type

[**BuildPoints**](BuildPoints.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **TrainBuildPoint**
> TrainBuildPoint(ctx, id)


Train a build point

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ctx** | **context.Context** | context for logging, tracing, authentication, etc.
  **id** | **string**| ID of build to be trained | 

### Return type

 (empty response body)

### Authorization

[ApiKey](../README.md#ApiKey), [Session](../README.md#Session)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

