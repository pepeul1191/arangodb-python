# encoding: utf-8
require_relative 'app'
require 'json'

def listar
  RSpec.describe App do
    describe "1. Listar empresas: " do
      it '1.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '1.2 Listar empresas' do
        url = 'empresa/listar'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
    end
  end
end

def crear
  RSpec.describe App do
    describe "2. Crear empresas: " do
      it '2.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '2.2 Crear empresas' do
        data = {
          :nuevos => [
            {
              :_id => 'tablaEmpresa_481',
              :razon_social => 'Corbett 2',  
              :ruc => '123123123123', 
              :nombre_comercial => 'Empresa Tincidunt tempus', 
              :domicilio_fiscal => 'AV. JAVIER PRADO ESTE NRO. 4600 URB. FUNDO MONTERRICO CHICO (JUNTO AL JOCKEY PLAZA)', 
              :distrito_id => 1001,
            },
            {
              :_id => 'tablaEmpresa_482',
              :razon_social => 'Corbett 2',  
              :ruc => '223123123123', 
              :nombre_comercial => 'Empresa Tincidunt ut libero', 
              :domicilio_fiscal => 'AV. JAVIER PRADO ESTE NRO. 4700 URB. FUNDO MONTERRICO CHICO (JUNTO AL JOCKEY PLAZA)', 
              :distrito_id => 1002,
            },
            {
              :_id => 'tablaEmpresa_483',
              :razon_social => 'Corbett 3',  
              :ruc => '323123123123', 
              :nombre_comercial => 'Empresa vitae sapien', 
              :domicilio_fiscal => 'AV. JAVIER PRADO ESTE NRO. 4800 URB. FUNDO MONTERRICO CHICO (JUNTO AL JOCKEY PLAZA)', 
              :distrito_id => 1003,
            },
            {
              :_id => 'tablaEmpresa_484',
              :razon_social => 'Corbett 3',  
              :ruc => '423123123123', 
              :nombre_comercial => 'Empresa vitae sapien lkasdjfuef', 
              :domicilio_fiscal => 'AV. JAVIER PRADO ESTE NRO. 4900 URB. FUNDO MONTERRICO CHICO (JUNTO AL JOCKEY PLAZA)', 
              :distrito_id => 1004,
            }  
          ],
          :editados => [],  
          :eliminados => [],
          :extra => {}
        }.to_json
        url = 'empresa/guardar?data=' + data
        test = App.new(url)
        test.post()
        expect(test.response.code).to eq(200)
        expect(test.response.body).not_to include('error')
        expect(test.response.body).to include('Se ha registrado los cambios en las empresas')
        expect(test.response.body).to include('nuevo_id')
        expect(test.response.body).to include('success')
      end
    end
  end
end

def editar
  RSpec.describe App do
    describe "3. Editar empresas: " do
      it '3.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '3.2 Editar empresas' do
        data = {
          :nuevos => [],
          :editados => [
            {
              :_id => '238251',
              :razon_social => 'EEEECorbett 2',  
              :ruc => '123123123123EE', 
              :nombre_comercial => 'EEEmpresa Tincidunt tempus', 
              :domicilio_fiscal => 'EEAV. JAVIER PRADO ESTE NRO. 4600 URB. FUNDO MONTERRICO CHICO (JUNTO AL JOCKEY PLAZA)', 
              :distrito_id => 1001,
            },
            {
              :_id => '236963',
              :razon_social => 'EEECorbett 2',  
              :ruc => '223123123123', 
              :nombre_comercial => 'Empresa Tincidunt ut libero', 
              :domicilio_fiscal => 'AV. JAVIER PRADO ESTE NRO. 4700 URB. FUNDO MONTERRICO CHICO (JUNTO AL JOCKEY PLAZA)', 
              :distrito_id => 1002,
            },
            {
              :_id => '238254',
              :razon_social => 'EEECorbett 3',  
              :ruc => '323123123123', 
              :nombre_comercial => 'Empresa vitae sapien', 
              :domicilio_fiscal => 'AV. JAVIER PRADO ESTE NRO. 4800 URB. FUNDO MONTERRICO CHICO (JUNTO AL JOCKEY PLAZA)', 
              :distrito_id => 1003,
            },
            {
              :_id => '238247',
              :razon_social => 'EEECorbett 3',  
              :ruc => '423123123123', 
              :nombre_comercial => 'Empresa vitae sapien lkasdjfuef', 
              :domicilio_fiscal => 'AV. JAVIER PRADO ESTE NRO. 4900 URB. FUNDO MONTERRICO CHICO (JUNTO AL JOCKEY PLAZA)', 
              :distrito_id => 1004,
            }  
          ],  
          :eliminados => [],
          :extra => {}
        }.to_json
        url = 'empresa/guardar?data=' + data
        test = App.new(url)
        test.post()
        expect(test.response.code).to eq(200)
        expect(test.response.body).not_to include('error')
        expect(test.response.body).to include('Se ha registrado los cambios en las empresas')
        expect(test.response.body).to include('success')
      end
    end
  end
end

def eliminar
  RSpec.describe App do
    describe "4. Eliminar empresas: " do
      it '4.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '4.2 Eliminar empresas' do
        data = {
          :nuevos => [],
          :editados => [],  
          :eliminados => ['236973', '238257'],
          :extra => {}
        }.to_json
        url = 'empresa/guardar?data=' + data
        test = App.new(url)
        test.post()
        expect(test.response.code).to eq(200)
        expect(test.response.body).not_to include('error')
        expect(test.response.body).to include('Se ha registrado los cambios en las empresas')
        expect(test.response.body).to include('success')
      end
    end
  end
end

#crear
#editar
eliminar