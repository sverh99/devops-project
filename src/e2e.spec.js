const request = require("supertest");
const server = require("./server");

describe("Sample Test", () => {
  afterAll((done) => {
    server.close(() => done());
  });

  it("/ping should return pong", async () => {
    const response = await request(server)
      .get("/ping")
      .set("Accept", "application/json")
      .send({
        variables: {},
      })
      .expect("Content-Type", /text\/html/)
      .expect(200);

    expect(response.text).toEqual("pong");
  });

  it("/ should return Hello world", async () => {
    const response = await request(server)
      .get("/")
      .set("Accept", "application/json")
      .send({
        variables: {},
      })
      .expect("Content-Type", /text\/html/)
      .expect(200);

    expect(response.text).toEqual("Hello world");
  });
});
