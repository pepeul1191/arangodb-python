# encoding: utf-8
require_relative 'app'
require 'json'

def listar
  RSpec.describe App do
    describe "1. Listar productos: " do
      it '1.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '1.2 Listar productos' do
        url = 'producto/listar'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
    end
  end
end

def crear
  RSpec.describe App do
    describe "2. Crear productos: " do
      it '2.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '2.2 Crear productos' do
        data = {
          :nuevos => [
            {
              :_id => 'tablaProducto_481',
              :nombre => 'Producto Corbett 1',  
              :precio_referencial => 2.13, 
              :imagen_id => nil, 
            },
            {
              :_id => 'tablaProducto_482',
              :nombre => 'Producto Corbett 2',  
              :precio_referencial => 3.20, 
              :imagen_id => nil, 
            },
            {
              :_id => 'tablaProducto_483',
              :nombre => 'Producto Corbett 3',  
              :precio_referencial => 4, 
              :imagen_id => nil, 
            },
            {
              :_id => 'tablaProducto_484',
              :nombre => 'Producto Corbett 4',  
              :precio_referencial => 0.1, 
              :imagen_id => nil, 
            },
          ],
          :editados => [],  
          :eliminados => [],
          :extra => {
          }
        }.to_json
        url = 'producto/guardar?data=' + data
        test = App.new(url)
        test.post()
        expect(test.response.code).to eq(200)
        expect(test.response.body).not_to include('error')
        expect(test.response.body).to include('Se ha registrado los cambios en los productos')
        expect(test.response.body).to include('nuevo_id')
        expect(test.response.body).to include('success')
      end
    end
  end
end

def editar
  RSpec.describe App do
    describe "3. Editar productos: " do
      it '3.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '3.2 Editar productos' do
        data = {
          :nuevos => [],
          :editados =>[ 
            {
              :_id => '257511',
              :nombre => 'Producto Editado Corbett 1',  
              :precio_referencial => 2.13, 
              :imagen_id => nil, 
            },
            {
              :_id => '257501',
              :nombre => 'Producto Editado Corbett 2',  
              :precio_referencial => 3.20, 
              :imagen_id => nil, 
            },
            {
              :_id => '257508',
              :nombre => 'Producto Editado Corbett 3',  
              :precio_referencial => 4, 
              :imagen_id => nil, 
            },
            {
              :_id => '257505',
              :nombre => 'Producto Editado Corbett 4',  
              :precio_referencial => 0.1, 
              :imagen_id => nil, 
            }
          ],  
          :eliminados => [],
          :extra => {
          }
        }.to_json
        url = 'producto/guardar?data=' + data
        test = App.new(url)
        test.post()
        expect(test.response.code).to eq(200)
        expect(test.response.body).not_to include('error')
        expect(test.response.body).to include('Se ha registrado los cambios en los productos')
        expect(test.response.body).to include('success')
      end
    end
  end
end

def eliminar
  RSpec.describe App do
    describe "4. Eliminar productos: " do
      it '4.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '4.2 Eliminar productos' do
        data = {
          :nuevos => [],
          :editados =>[],  
          :eliminados => ['257511','257501','257508','257505'],
          :extra => {
          }
        }.to_json
        url = 'producto/guardar?data=' + data
        test = App.new(url)
        test.post()
        expect(test.response.code).to eq(200)
        expect(test.response.body).not_to include('error')
        expect(test.response.body).to include('Se ha registrado los cambios en los productos')
        expect(test.response.body).to include('success')
      end
    end
  end
end


#listar
#crear
#editar
eliminar