# encoding: utf-8
require_relative 'app'
require 'json'

def listar
  RSpec.describe App do
    describe "1. Listar locales: " do
      it '1.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '1.2 Listar locales' do
        url = 'local/listar/empresa123'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
    end
  end
end

def crear
  RSpec.describe App do
    describe "2. Crear locales: " do
      it '2.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '2.2 Crear locales' do
        data = {
          :nuevos => [
            {
              :_id => 'tablaLocal_481',
              :nombre => 'Local Corbett 2',  
              :direccion => 'LOCAL 2 AV. JAVIER PRADO ESTE NRO. 4600 URB. FUNDO MONTERRICO CHICO (JUNTO AL JOCKEY PLAZA)', 
              :latitud => -12.088243, 
              :longitud => -76.970056, 
              :empresa => 1001,
              :imagen_id => nil, 
              :distrito_id => 2 
            },
            {
              :_id => 'tablaLocal_482',
              :nombre => 'Local Corbett 3',  
              :direccion => 'LOCAL 3 AV. JAVIER PRADO ESTE NRO. 4600 URB. FUNDO MONTERRICO CHICO (JUNTO AL JOCKEY PLAZA)', 
              :latitud => -13.088243, 
              :longitud => -77.970056, 
              :empresa => 1001,
              :imagen_id => nil, 
              :distrito_id => 12
            },
            {
              :_id => 'tablaLocal_483',
              :nombre => 'Local Corbett 4',  
              :direccion => 'LOCAL 4 AV. JAVIER PRADO ESTE NRO. 4600 URB. FUNDO MONTERRICO CHICO (JUNTO AL JOCKEY PLAZA)', 
              :latitud => -14.088243, 
              :longitud => -78.970056, 
              :empresa => 1002,
              :imagen_id => nil, 
              :distrito_id => 72
            },
            {
              :_id => 'tablaLocal_484',
              :nombre => 'Local Corbett 5',  
              :direccion => 'LOCAL 5 AV. JAVIER PRADO ESTE NRO. 4600 URB. FUNDO MONTERRICO CHICO (JUNTO AL JOCKEY PLAZA)', 
              :latitud => -15.088243, 
              :longitud => -78.970056, 
              :empresa => 1001,
              :imagen_id => nil, 
              :distrito_id => 23
            }  
          ],
          :editados => [],  
          :eliminados => [],
          :extra => {
            :empresa_id => 'empresa123'
          }
        }.to_json
        url = 'local/guardar?data=' + data
        test = App.new(url)
        test.post()
        expect(test.response.code).to eq(200)
        expect(test.response.body).not_to include('error')
        expect(test.response.body).to include('Se ha registrado los cambios en los locales')
        expect(test.response.body).to include('nuevo_id')
        expect(test.response.body).to include('success')
      end
    end
  end
end

def editar
  RSpec.describe App do
    describe "3. Editar locales: " do
      it '3.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '3.2 Editar locales' do
        data = {
          :nuevos => [],
          :editados => [
            {
              :_id => '251017',
              :nombre => 'Local Corbett 2_B',  
              :direccion => 'LOCAL 2 AV. JAVIER PRADO ESTE NRO. 4600 URB. FUNDO MONTERRICO CHICO (JUNTO AL JOCKEY PLAZA)', 
              :latitud => -12.088243, 
              :longitud => -76.970056, 
              :empresa => 1001,
              :imagen_id => nil, 
              :distrito_id => 2 
            },
            {
              :_id => '251024',
              :nombre => 'Local Corbett 3_B',  
              :direccion => 'LOCAL 3 AV. JAVIER PRADO ESTE NRO. 4600 URB. FUNDO MONTERRICO CHICO (JUNTO AL JOCKEY PLAZA)', 
              :latitud => -13.088243, 
              :longitud => -77.970056, 
              :empresa => 1001,
              :imagen_id => nil, 
              :distrito_id => 12
            },
            {
              :_id => '251027',
              :nombre => 'Local Corbett 4_B',  
              :direccion => 'LOCAL 4 AV. JAVIER PRADO ESTE NRO. 4600 URB. FUNDO MONTERRICO CHICO (JUNTO AL JOCKEY PLAZA)', 
              :latitud => -14.088243, 
              :longitud => -78.970056, 
              :empresa => 1002,
              :imagen_id => nil, 
              :distrito_id => 72
            },
            {
              :_id => '251021',
              :nombre => 'Local Corbett 5_B',  
              :direccion => 'LOCAL 5 AV. JAVIER PRADO ESTE NRO. 4600 URB. FUNDO MONTERRICO CHICO (JUNTO AL JOCKEY PLAZA)', 
              :latitud => -15.088243, 
              :longitud => -78.970056, 
              :empresa => 1001,
              :imagen_id => nil, 
              :distrito_id => 23
            }  
          ],  
          :eliminados => [],
          :extra => {
            :empresa_id => 'empresa123'
          }
        }.to_json
        url = 'local/guardar?data=' + data
        test = App.new(url)
        test.post()
        expect(test.response.code).to eq(200)
        expect(test.response.body).not_to include('error')
        expect(test.response.body).to include('Se ha registrado los cambios en los locales')
        expect(test.response.body).to include('success')
      end
    end
  end
end

def eliminar
  RSpec.describe App do
    describe "3. Eliminar locales: " do
      it '3.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '3.2 Eliminar locales' do
        data = {
          :nuevos => [],
          :editados => [],  
          :eliminados => ['251017','251024','251027','251021'],
          :extra => {
            :empresa_id => 'empresa123'
          }
        }.to_json
        url = 'local/guardar?data=' + data
        test = App.new(url)
        test.post()
        expect(test.response.code).to eq(200)
        expect(test.response.body).not_to include('error')
        expect(test.response.body).to include('Se ha registrado los cambios en los locales')
        expect(test.response.body).to include('success')
      end
    end
  end
end

#listar
#crear
#editar
#eliminar