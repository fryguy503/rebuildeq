@echo off
protoc --cpp_out=../common/proto --go_out=../go/eqproto *.proto