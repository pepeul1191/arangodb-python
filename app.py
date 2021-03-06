#!/usr/bin/env python
# -*- coding: utf-8 -*-
from bottle import Bottle, run, HTTPResponse, static_file, hook
from views.empresa import empresa_view
from views.local import local_view
from views.producto import producto_view

app = Bottle()

@hook('after_request')
def enable_cors():
	response.headers['Access-Control-Allow-Origin'] = '*'
	response.headers['x-powered-by'] = 'Ubuntu'

@app.route('/')
def index():
	the_body = 'Error : URI vacía'
	return HTTPResponse(status=404, body=the_body)

@app.route('/test/conexion')
def test_conexion():
	return 'Ok'

@app.route('/:filename#.*#')
def send_static(filename):
  return static_file(filename, root='./static/')

if __name__ == '__main__':
	app.mount('/empresa', empresa_view)
	app.mount('/local', local_view)
	app.mount('/producto', producto_view)
	app.run(host='localhost', port=3021, debug=True, reloader=True)
	#app.run(host='localhost', port=3021, debug=True)