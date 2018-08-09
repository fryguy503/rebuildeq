package web

import (
	"fmt"
	"net/http"
	"strings"

	"github.com/dgrijalva/jwt-go"
	"github.com/pkg/errors"
	"github.com/xackery/rebuildeq/go/eqproto"
)

// AuthClaim is used for jwt holding
type AuthClaim struct {
	user *eqproto.User
	jwt.StandardClaims
}

func (s *Service) getAuthClaim(r *http.Request) (*AuthClaim, error) {
	auth := &AuthClaim{
		user: &eqproto.User{},
	}
	tokens, ok := r.Header["Authorization"]
	token := ""
	if ok && len(tokens) >= 1 {
		token = tokens[0]
		token = strings.TrimPrefix(token, "Bearer ")
	}

	if token == "" {
		cookie, err := r.Cookie("token")
		if err != nil {
			if err == http.ErrNoCookie {
				return auth, nil
			}
			return auth, err
		}
		token = cookie.String()
		if len(token) > 6 { //strip out token=
			token = token[6:]
		}
	}

	if token == "" || token == "undefined" {
		return auth, fmt.Errorf("No Token Provided")
	}

	parsedToken, err := jwt.ParseWithClaims(token, &AuthClaim{}, func(token *jwt.Token) (interface{}, error) {
		if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, fmt.Errorf("Unexpected signing method: %v", token.Header["alg"])
		}
		return s.mySigningKey, nil
	})
	if err != nil {
		return auth, errors.Wrap(err, "failed to parse token")
	}

	if claims, ok := parsedToken.Claims.(*AuthClaim); ok && parsedToken.Valid {
		return claims, nil
	}
	return auth, fmt.Errorf("Invalid Token")
}
