# \ChangelogApi

All URIs are relative to *https://app.rebuildeq.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**GetChangelog**](ChangelogApi.md#GetChangelog) | **Get** /changelog/{changelogId}/detail | 
[**ListChangelog**](ChangelogApi.md#ListChangelog) | **Get** /changelog | 


# **GetChangelog**
> Changelog GetChangelog(ctx, changelogId)


Get changelog by id

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ctx** | **context.Context** | context for logging, tracing, authentication, etc.
  **changelogId** | **int32**| ID of changelog | 

### Return type

[**Changelog**](Changelog.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **ListChangelog**
> []Changelog ListChangelog(ctx, )


Get listing of most recent changelog

### Required Parameters
This endpoint does not need any parameter.

### Return type

[**[]Changelog**](Changelog.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

