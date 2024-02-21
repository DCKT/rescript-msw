# rescript-msw

ReScript bindings for [msw](https://mswjs.io/) (targeted version : `^2.2.1`)

## Setup

1. Install the module

```bash
bun install @dck/rescript-msw
# or
yarn install @dck/rescript-msw
# or
npm install @dck/rescript-msw
```

2. Add it to your `rescript.json` config

```json
{
  "bs-dependencies": ["@dck/rescript-msw"]
}
```

## Usage

The functions can be accessed through `Msw` module.

```rescript
@spice
type example = {
  id: string,
  username: string,
  age: int
}

let worker = Msw.setupWorker([
  Msw.Http.get("https://fakeapi.com/test", _ => {
    let ex: example = {
      id: "id",
      username: "mock",
      age: 31
    }
    Msw.HttpResponse.jsonUnsafe(ex)
  }),
  Msw.Http.get("https://fakeapi.com/params/:id", ({params}) => {
    let paramsId = params->Js.Dict.get("id")

    let ex: example = {
      id: paramsId->Option.getOr("1"),
      username: "mock",
      age: 31,
    }
    Msw.HttpResponse.json(ex->example_encode)
  }),
])
```

## Development

Install deps

```bash
bun install
```

Compiles files

```bash
bun run dev
```

Run tests

```bash
bun test
```
