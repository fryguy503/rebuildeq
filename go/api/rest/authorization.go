package rest

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strings"
	"time"

	"github.com/dgrijalva/jwt-go"
)

type AuthClaims struct {
	Admin     bool `json:"admin"`
	AccountId int  `json:"accountId"`
	jwt.StandardClaims
}

func PostLogin(w http.ResponseWriter, r *http.Request) {
	var err error
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	type LoginResponse struct {
		ApiKey    string `json:"apiKey"`
		ExpiresAt int64  `json:"expiresAt"`
	}

	expiresAt := time.Now().Add(time.Hour * 24).Unix()

	claims := AuthClaims{
		false,
		74887,
		jwt.StandardClaims{
			ExpiresAt: expiresAt,
		},
	}
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)

	tokenString, _ := token.SignedString(mySigningKey)

	loginResponse := LoginResponse{
		ApiKey:    tokenString,
		ExpiresAt: expiresAt,
	}
	fmt.Println(expiresAt)

	js := []byte{}
	if js, err = json.Marshal(loginResponse); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.WriteHeader(http.StatusOK)
	w.Write(js)
}
func getAuthClaims(r *http.Request) (*AuthClaims, error) {
	tokens, ok := r.Header["Authorization"]
	token := ""
	if ok && len(tokens) >= 1 {
		token = tokens[0]
		token = strings.TrimPrefix(token, "Bearer ")
	}

	if token == "" {
		return nil, fmt.Errorf("No Token Provided")
	}

	parsedToken, err := jwt.ParseWithClaims(token, &AuthClaims{}, func(token *jwt.Token) (interface{}, error) {
		// Don't forget to validate the alg is what you expect:
		if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, fmt.Errorf("Unexpected signing method: %v", token.Header["alg"])
		}

		// hmacSampleSecret is a []byte containing your secret, e.g. []byte("my_secret_key")
		return mySigningKey, nil
	})
	if err != nil {
		return nil, fmt.Errorf("Invalid Token: %s", err.Error())
	}

	if claims, ok := parsedToken.Claims.(*AuthClaims); ok && parsedToken.Valid {
		return claims, nil
	}
	return nil, fmt.Errorf("Invalid Token")
}
