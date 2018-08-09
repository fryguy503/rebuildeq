package web

import (
	"net/http"

	"github.com/pkg/errors"
	"github.com/xackery/rebuildeq/go/eqproto"
)

// BuildRequest is a list of parameters used for build
// swagger:parameters deleteBuild editBuild getBuild
type BuildRequest struct {
	// ID to get information about
	// in: path
	// example: 1
	ID int64 `json:"ID"`
}

// BuildResponse is what endpoints respond with
// swagger:response
type BuildResponse struct {
	Build *eqproto.Build `json:"build,omitempty"`
}

// BuildCreateRequest is the body parameters for creating an build
// swagger:parameters createBuild
type BuildCreateRequest struct {
	// Build details to create
	// in: body
	Build *eqproto.Build `json:"build"`
}

// BuildEditRequest is the body parameters for creating an build
// swagger:parameters editBuild
type BuildEditRequest struct {
	// ID to get information about
	// in: path
	// example: 1
	ID int64 `json:"ID"`
	// Build details to edit
	// in: body
	Build *eqproto.Build `json:"build"`
}

// BuildsRequest is a list of parameters used for build
// swagger:parameters listBuild
type BuildsRequest struct {
	// Offset is pagination, offset*limit
	// example: 0
	// in: query
	Offset int64 `json:"offset"`
	// Limit to how many items per page
	// example: 10
	// in: query
	Limit int64 `json:"limit"`
	// OrderBy is which field to order a page by
	// example: name
	// in: query
	OrderBy string `json:"orderBy"`
	// IsDescending will change sort order when true
	// example: 0
	// in: query
	IsDescending int64 `json:"isDescending"`
}

// BuildsResponse is a general response to a request
// swagger:response
type BuildsResponse struct {
	Page   *eqproto.Page  `json:"page,omitempty"`
	Builds eqproto.Builds `json:"builds,omitempty"`
}

// BuildsBySearchRequest is a list of parameters used for build
// swagger:parameters listBuildBySearch
type BuildsBySearchRequest struct {
	// Name is which build to get information about
	// example: xackery
	// in: query
	Name string `json:"name"`
	// Offset is pagination, offset*limit
	// example: 0
	// in: query
	Offset int64 `json:"offset"`
	// Limit to how many items per page
	// example: 10
	// in: query
	Limit int64 `json:"limit"`
	// OrderBy is which field to order a page by
	// example: name
	// in: query
	OrderBy string `json:"orderBy"`
	// IsDescending will change sort order when true
	// example: 0
	// in: query
	IsDescending int64 `json:"isDescending"`
}

// BuildsBySearchResponse is a general response to a request
// swagger:response
type BuildsBySearchResponse struct {
	Search *eqproto.Build `json:"search,omitempty"`
	Page   *eqproto.Page  `json:"page,omitempty"`
	Builds eqproto.Builds `json:"builds,omitempty"`
}

func (s *Service) buildRoutes() (routes []*route) {

	routes = []*route{
		// swagger:route GET /build/{ID} build getBuild
		//
		// Get an build
		//
		// This will get an individual build available builds by default.
		//
		//     Responses:
		//       default: ErrInternal
		//       200: BuildResponse
		//       400: ErrValidation
		//		 401: ErrPermission
		{
			"GetBuild",
			"GET",
			"/build/{ID:[0-9]+}",
			s.getBuild,
		},
		// swagger:route PUT /build/{ID} build editBuild
		//
		// Edit an build
		//
		// This will edit an build
		//
		//     Security:
		//       apiKey:
		//
		//     Responses:
		//       default: ErrInternal
		//		 200: BuildResponse
		//       204: ErrNoContent
		//       400: ErrValidation
		//		 401: ErrPermission
		{
			"EditBuild",
			"PUT",
			"/build/{ID:[0-9]+}",
			s.editBuild,
		},
	}
	return
}

func (s *Service) getBuild(w http.ResponseWriter, r *http.Request, user *eqproto.User, statusCode int) (content interface{}, err error) {
	//request := &BuildRequest{
	//	ID: s.getIntVar(r, "ID"),
	//}

	build := &eqproto.Build{
	//ID: request.ID,
	}

	err = s.sql.GetBuild(build, user)
	if err != nil {
		return
	}
	response := &BuildResponse{
		Build: build,
	}
	content = response
	return
}

func (s *Service) editBuild(w http.ResponseWriter, r *http.Request, user *eqproto.User, statusCode int) (content interface{}, err error) {
	//request := &BuildEditRequest{
	//	ID: s.getIntVar(r, "ID"),
	//}

	build := &eqproto.Build{
	//ID: request.ID,
	}

	err = s.decodeBody(r, build)
	if err != nil {
		err = errors.Wrap(err, "Request error")
		return
	}

	err = s.sql.EditBuild(build, user)
	if err != nil {
		return
	}
	response := &BuildResponse{
		Build: build,
	}
	content = response
	return
}
