# \BuildApi

All URIs are relative to *https://app.rebuildeq.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**ListBuild**](BuildApi.md#ListBuild) | **Get** /character/{characterId}/build | 
[**TrainBuild**](BuildApi.md#TrainBuild) | **Put** /character/{characterId}/build/{buildId}/detail | 


# **ListBuild**
> BuildPoints ListBuild(ctx, characterId)


Get all trained build points

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ctx** | **context.Context** | context for logging, tracing, authentication, etc.
  **characterId** | **int32**| ID of character | 

### Return type

[**BuildPoints**](BuildPoints.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **TrainBuild**
> TrainBuild(ctx, characterId, buildId)


Train a build point

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ctx** | **context.Context** | context for logging, tracing, authentication, etc.
  **characterId** | **int32**| ID of character | 
  **buildId** | **int32**| ID of build | 

### Return type

 (empty response body)

### Authorization

[ApiKey](../README.md#ApiKey), [Session](../README.md#Session)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

