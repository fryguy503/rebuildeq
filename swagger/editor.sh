#!/bin/bash
echo "Access the editor by pointing your browser to http://localhost:8080. CTRL+C to exit"
docker run -p 8080:8080 swaggerapi/swagger-editor
