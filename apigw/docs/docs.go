// Code generated by swaggo/swag. DO NOT EDIT.

package docs

import "github.com/swaggo/swag"

const docTemplate = `{
    "schemes": {{ marshal .Schemes }},
    "swagger": "2.0",
    "info": {
        "description": "{{escape .Description}}",
        "title": "{{.Title}}",
        "termsOfService": "http://swagger.io/terms/",
        "contact": {
            "name": "API Support Gateway",
            "email": "ataradaev@swagger.io"
        },
        "license": {
            "name": "Apache 2.0",
            "url": "http://www.apache.org/licenses/LICENSE-2.0.html"
        },
        "version": "{{.Version}}"
    },
    "host": "{{.Host}}",
    "basePath": "{{.BasePath}}",
    "paths": {
        "/comment/{id}": {
            "get": {
                "description": "получает дерево комментариев для определеной новости",
                "produces": [
                    "application/json"
                ],
                "summary": "получение  коментариев для новости",
                "operationId": "tree comment",
                "parameters": [
                    {
                        "type": "integer",
                        "description": "id Новости",
                        "name": "id",
                        "in": "path",
                        "required": true
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Дерево комментариев",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/model.Comment"
                            }
                        }
                    },
                    "500": {
                        "description": "внутренняя ошибка сервера",
                        "schema": {
                            "type": "string"
                        }
                    }
                }
            },
            "post": {
                "description": "Добавляет коментарий для определенной новости",
                "produces": [
                    "text/plain"
                ],
                "summary": "добавление коментария",
                "operationId": "tree comment",
                "parameters": [
                    {
                        "description": "структура комментарий",
                        "name": "Комментарий",
                        "in": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/model.Comment"
                        }
                    },
                    {
                        "type": "integer",
                        "description": "Ид новости",
                        "name": "id",
                        "in": "path",
                        "required": true
                    }
                ],
                "responses": {
                    "200": {
                        "description": "коментарий добавлен",
                        "schema": {
                            "type": "string"
                        }
                    },
                    "403": {
                        "description": "Комментарий содержит запрещенные слова",
                        "schema": {
                            "type": "string"
                        }
                    },
                    "500": {
                        "description": "внутренняя ошибка сервера",
                        "schema": {
                            "type": "string"
                        }
                    }
                }
            },
            "delete": {
                "description": "deleted comment from news",
                "produces": [
                    "text/plain"
                ],
                "summary": "Delete comment",
                "operationId": "del comment",
                "parameters": [
                    {
                        "type": "integer",
                        "description": "id комментария для удаления",
                        "name": "id",
                        "in": "path",
                        "required": true
                    }
                ],
                "responses": {
                    "200": {
                        "description": "коментарий удален",
                        "schema": {
                            "type": "string"
                        }
                    },
                    "500": {
                        "description": "внутренняя ошибка сервера",
                        "schema": {
                            "type": "string"
                        }
                    }
                }
            }
        },
        "/news/detail/{id}": {
            "get": {
                "description": "Детальная новость",
                "produces": [
                    "application/json"
                ],
                "summary": "новость с коментариями",
                "operationId": "detail news",
                "parameters": [
                    {
                        "type": "integer",
                        "description": "Ид новости",
                        "name": "id",
                        "in": "path",
                        "required": true
                    }
                ],
                "responses": {
                    "200": {
                        "description": "новость",
                        "schema": {
                            "$ref": "#/definitions/model.FullNew"
                        }
                    },
                    "500": {
                        "description": "внутренняя ошибка сервера",
                        "schema": {
                            "type": "string"
                        }
                    }
                }
            }
        },
        "/news/page/{id}": {
            "get": {
                "description": "новости постранично",
                "produces": [
                    "application/json"
                ],
                "summary": "список новостей с страницы",
                "operationId": "page news",
                "parameters": [
                    {
                        "type": "integer",
                        "description": "номер страницы",
                        "name": "id",
                        "in": "path",
                        "required": true
                    },
                    {
                        "type": "integer",
                        "description": " количество новостей на странице",
                        "name": "count",
                        "in": "query"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "массив новостей",
                        "schema": {
                            "$ref": "#/definitions/model.ArrayShortNews"
                        }
                    },
                    "500": {
                        "description": "внутренняя ошибка сервера",
                        "schema": {
                            "type": "string"
                        }
                    }
                }
            }
        },
        "/news/search": {
            "get": {
                "description": "поиск и сортировка новостей по параметрам",
                "produces": [
                    "application/json"
                ],
                "summary": "поиск новостей по  фильтру",
                "operationId": "search news",
                "parameters": [
                    {
                        "type": "string",
                        "description": "слово для поиска",
                        "name": "word",
                        "in": "query"
                    },
                    {
                        "enum": [
                            0,
                            1,
                            2,
                            3
                        ],
                        "type": "integer",
                        "description": "условиесортировки: 0- слово целиком, 1-часть слова, 2-не включая слово, не включая часть слова",
                        "name": "type",
                        "in": "query"
                    },
                    {
                        "enum": [
                            "id",
                            "title",
                            "desc",
                            "data",
                            "url"
                        ],
                        "type": "string",
                        "description": "сортировка по полю",
                        "name": "sort",
                        "in": "query"
                    },
                    {
                        "enum": [
                            "asc",
                            "desc"
                        ],
                        "type": "string",
                        "description": "сортировка по полю ",
                        "name": "direction",
                        "in": "query"
                    },
                    {
                        "type": "integer",
                        "description": "начальная дата новостей (Unix-формат)",
                        "name": "startdate",
                        "in": "query"
                    },
                    {
                        "type": "integer",
                        "description": "конечная дата новостей (Unix-формат)",
                        "name": "enddate",
                        "in": "query"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "массив новостей\"//",
                        "schema": {
                            "$ref": "#/definitions/model.ArrayShortNews"
                        }
                    },
                    "500": {
                        "description": "внутренняя ошибка сервера",
                        "schema": {
                            "type": "string"
                        }
                    }
                }
            }
        },
        "/news/{id}": {
            "get": {
                "description": "последние новости",
                "produces": [
                    "application/json"
                ],
                "summary": "список последних новостей",
                "operationId": "page news latest",
                "parameters": [
                    {
                        "type": "integer",
                        "description": "Количество последних новостей для веб-интерфейса",
                        "name": "id",
                        "in": "path",
                        "required": true
                    }
                ],
                "responses": {
                    "200": {
                        "description": "массив новостей",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/model.ShortNew"
                            }
                        }
                    },
                    "500": {
                        "description": "внутренняя ошибка сервера",
                        "schema": {
                            "type": "string"
                        }
                    }
                }
            }
        }
    },
    "definitions": {
        "model.ArrayShortNews": {
            "type": "object",
            "properties": {
                "CountPage": {
                    "description": "количество страниц",
                    "type": "integer"
                },
                "array": {
                    "description": "массив новостей",
                    "type": "array",
                    "items": {
                        "$ref": "#/definitions/model.ShortNew"
                    }
                }
            }
        },
        "model.Comment": {
            "type": "object",
            "properties": {
                "authorid": {
                    "description": "ИД автора новости(неиспоьзуется)",
                    "type": "integer"
                },
                "child": {
                    "description": "дочерние комментарии",
                    "type": "object",
                    "additionalProperties": {
                        "$ref": "#/definitions/model.Comment"
                    }
                },
                "content": {
                    "description": "содержание",
                    "type": "string"
                },
                "id": {
                    "description": "номер коментария",
                    "type": "integer"
                },
                "idnews": {
                    "description": "номер новости",
                    "type": "integer"
                },
                "parent": {
                    "description": "родительский коментарий",
                    "type": "integer"
                },
                "time": {
                    "description": "время создания новости",
                    "type": "integer"
                }
            }
        },
        "model.FullNew": {
            "type": "object",
            "properties": {
                "Commments": {
                    "description": "коментарии",
                    "type": "object",
                    "additionalProperties": {
                        "$ref": "#/definitions/model.Comment"
                    }
                },
                "News": {
                    "description": "Новость",
                    "allOf": [
                        {
                            "$ref": "#/definitions/model.ShortNew"
                        }
                    ]
                }
            }
        },
        "model.ShortNew": {
            "type": "object",
            "properties": {
                "Content": {
                    "description": "содержание публикации",
                    "type": "string"
                },
                "Hash": {
                    "description": "Хеш  новости",
                    "type": "integer"
                },
                "ID": {
                    "description": "номер записи",
                    "type": "integer"
                },
                "Link": {
                    "description": "ссылка на источник",
                    "type": "string"
                },
                "PubTime": {
                    "description": "время публикации",
                    "type": "integer"
                },
                "Title": {
                    "description": "заголовок публикации",
                    "type": "string"
                }
            }
        }
    },
    "tags": [
        {
            "name": "news server"
        }
    ]
}`

// SwaggerInfo holds exported Swagger Info so clients can modify it
var SwaggerInfo = &swag.Spec{
	Version:          "1.0",
	Host:             "",
	BasePath:         "/",
	Schemes:          []string{},
	Title:            "Маршрутизатор  агрегатора новостей",
	Description:      "Rest api for collect news",
	InfoInstanceName: "swagger",
	SwaggerTemplate:  docTemplate,
	LeftDelim:        "{{",
	RightDelim:       "}}",
}

func init() {
	swag.Register(SwaggerInfo.InstanceName(), SwaggerInfo)
}