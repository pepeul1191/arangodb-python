#!/usr/bin/env python
# -*- coding: utf-8 -*-
from config.model import Model

class Empresa(Model):
  # Atributos : _id, nombre
  def listar(self):
    rpta = []
    empresas = self.db.collection('empresas')
    for empresa in empresas:
      rpta.append({'_id': empresa['_key'], 'razon_social': empresa['razon_social']})
    return rpta