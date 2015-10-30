chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'pingpong', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()

    require('../src/pingpong')(@robot)

  it 'registers a respond listener', ->
    expect(@robot.respond).to.have.been.calledWith(/ping pong 10-3 dave1 dave2/)

  it 'registers a hear listener', ->
    expect(@robot.hear).to.have.been.calledWith(/ping pong stats/)
