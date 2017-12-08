/*
 * RebuildEQ API
 *
 * RebuildEQ API
 *
 * API version: 1.0.0
 * Contact: rebuildeq@gmail.com
 * Generated by: Swagger Codegen (https://github.com/swagger-api/swagger-codegen.git)
 */

package client

type Npc struct {

	Name string `json:"name,omitempty"`

	Id int32 `json:"id,omitempty"`

	SpawnsIn []SpawnEntry `json:"spawnsIn,omitempty"`
}
