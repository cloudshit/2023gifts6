const fastify = require('fastify')({ logger: true })
const superagent = require('superagent')

let promocode = ''

function fn () {
  superagent
    .get('https://raw.githubusercontent.com/cloud-skills/study/main/July_2023/day6/promotion_code.txt')
    .then((res) => promocode = res.text)
    .catch(() => {})
}

fn()
setInterval(fn, 10 * 1000)

fastify.get('/event', (req, res) => {
  res.send(promocode)
})

fastify.get('/healthz', (req, res) => {
  res.send({ success: true })
})

fastify.listen({ port: 8080, host: '0.0.0.0' }, (err) => {
  if (err) {
    fastify.log.error(err)
    process.exit(1)
  }
})
