type mock
type worker
type server = {listen: unit => unit, resetHandlers: unit => unit, close: unit => unit}
@module("msw/browser") @variadic
external setupWorker: array<mock> => worker = "setupWorker"
@module("msw/node") @variadic
external setupServer: array<mock> => server = "setupServer"

type rec startOptions = {serviceWorker?: serviceWorker, quiet?: bool}
and serviceWorker = {url: string}

@send
external start: (worker, startOptions) => unit = "start"
@send
external stop: worker => unit = "stop"

@module("msw")
external delay: unit => promise<unit> = "delay"
@module("msw")
external delayCustom: int => promise<'err> = "delay"

module HttpResponse = {
  type t
  type options = {
    status?: int,
    statusText?: string,
    headers?: Js.Dict.t<string>,
  }

  @module("msw") @scope("HttpResponse")
  external json: Js.Json.t => t = "json"
  @module("msw") @scope("HttpResponse")
  external jsonUnsafe: 'a => t = "json"

  @module("msw") @scope("HttpResponse")
  external jsonWithOptions: (Js.Json.t, options) => t = "json"
  @module("msw") @scope("HttpResponse")
  external jsonUnsafeWithOptions: (Js.Json.t, options) => t = "json"
}
type request = {
  method: string,
  url: string,
}

type httpRequest = {
  request: request,
  params: Js.Dict.t<string>,
  cookies: Js.Dict.t<string>,
}

module Http = {
  @module("msw") @scope("http")
  external get: (string, httpRequest => HttpResponse.t) => mock = "get"
  @module("msw") @scope("http")
  external put: (string, httpRequest => HttpResponse.t) => mock = "put"
  @module("msw") @scope("http")
  external post: (string, httpRequest => HttpResponse.t) => mock = "post"
  @module("msw") @scope("http")
  external delete: (string, httpRequest => HttpResponse.t) => mock = "delete"
  @module("msw") @scope("http")
  external all: (string, httpRequest => HttpResponse.t) => mock = "all"

  @module("msw") @scope("http")
  external getAsync: (string, httpRequest => promise<HttpResponse.t>) => mock = "get"
  @module("msw") @scope("http")
  external putAsync: (string, httpRequest => promise<HttpResponse.t>) => mock = "put"
  @module("msw") @scope("http")
  external postAsync: (string, httpRequest => promise<HttpResponse.t>) => mock = "post"
  @module("msw") @scope("http")
  external deleteAsync: (string, httpRequest => promise<HttpResponse.t>) => mock = "delete"
  @module("msw") @scope("http")
  external allAsync: (string, httpRequest => promise<HttpResponse.t>) => mock = "all"
}

@module("msw")
external passthrough: unit => HttpResponse.t = "passthrough"
