open RescriptBun
open Test

type data = {
  id: string,
  username: string,
  age: int,
}

let mockedURL = "https://fakeapi.com"

let server = Msw.setupServer([
  Msw.Http.get(`${mockedURL}/get`, _ => {
    let ex: data = {
      id: "id",
      username: "mock",
      age: 31,
    }
    Msw.HttpResponse.jsonUnsafe(ex)
  }),
])

beforeAll(() => {
  server.listen()
})

afterAll(() => {
  server.close()
})

testAsync("working server", async () => {
  let data: data = await Ky.get("get", ~options={prefixUrl: mockedURL}).json()

  expect(data.age)->Expect.toBe(31)
})
