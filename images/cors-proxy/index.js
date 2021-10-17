const fastify = require("fastify")({
  logger: false,
});
const corsHeader = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "Origin, X-Requested-With, Content-Type, Accept",
  "Access-Control-Allow-Methods": "GET, POST",
};
const axios = require("axios");
function answer(req, reply, result) {
  return reply.status(result.status).headers(corsHeader).send(result.data);
}
const randomWait = () =>
  new Promise((r) => {
    setTimeout(r, Math.floor(Math.random() * 10000));
  });
fastify.route({
  method: ["GET", "POST"],
  url: "/",
  bodyLimit: 65536,
  handler: async (request, reply) => {
    if (!request.query.url) {
      throw new Error("`url` query parameter is required");
    }
    try {
      const url = decodeURIComponent(request.query.url);
      const result = await axios({
        method: request.method.toLowerCase(),
        url,
        data: request.body,
        headers: {
          "User-Agent":
            request.headers["user-agent"] ||
            'Surprisingly some servers return error if UA starts from "axios/"',
        },
      });

      return answer(request, reply, result);
    } catch (e) {
      if (e.response) {
        return answer(request, reply, e.response);
      }
      if (e.request) {
        return reply
          .status(510)
          .send({ success: false, reason: "Destination Error" });
      }
      return reply
        .status(510)
        .send({ success: false, reason: "Destination Error" });
    }
  },
});

// Run the server!
fastify.listen(parseInt(process.argv[2]) || 8080, "0.0.0.0", (err, address) => {
  if (err) throw err;
});
