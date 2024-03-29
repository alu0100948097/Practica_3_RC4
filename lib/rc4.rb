require 'colorize'

class Rc4
	
	attr_reader :S, :semilla, :texto, :K
	
	def initialize
		@S=(0..255).to_a
        @semilla=[]
        @texto=[]
        @K=[]
        @texto_c=[]
	end
    
    def reset
        @S=(0..255).to_a
        @semilla=[]
        @texto=[]
        @K=[]
        @texto_c=[]
    end
    
    def inicializacion
        for i in (0..@S.length-1)
            @K.push(semilla[i%semilla.length])
		end
        j=0
        for i in (0..@S.length-1)
            j=(j+@S[i]+@K[i])%@S.length
            @S[i],@S[j]=@S[j],@S[i]
		end
    end
    
    def cifrado
        w=3
        i=0
        j=0
        k=0
        t=0
        for r in (0..@texto.length-1)
            i=(i+w)%@S.length
            j=(k+@S[(j+@S[i])%@S.length])%@S.length
            k=(i+k+@S[j%@S.length])%@S.length
            @S[i],@S[j]=@S[j],@S[i]
            t=(@S[(j+@S[(i+@S[(t+k)%@S.length])%@S.length])%@S.length])%@S.length
            #El código comentado es el RC4 sin modificación
            #i=(i+1)%@S.length
            #j=(j+@S[i])%@S.length
            #@S[i],@S[j]=@S[j],@S[i]
            #t=(@S[i]+@S[j])%@S.length
            puts "Byte #{r+1} de secuencia cifrante: S[#{t}]=#{@S[t]}:      #{@S[t].to_s(2).rjust(8,'0')}"
            puts "Byte #{r+1} de texto original: M[#{r+1}]=#{@texto[r]}:            #{@texto[r].to_s(2).rjust(8,'0')}"
            @texto_c.push((@S[t].to_s(2).rjust(8,'0').unpack('C*')).zip(@texto[r].to_s(2).rjust(8,'0').unpack('C*')))
            @texto_c[r]=@texto_c[r].map{ |a,b| a^b }
            puts "Byte #{r+1} de texto cifrado: C[#{r+1}]=#{@texto_c[r].join.to_i(2)}:             #{@texto_c[r].join.rjust(8,'0')}"
        end
        puts
        print "Texto cifrado en binario: "
        for r in (0..@texto_c.length-1)
            print "#{@texto_c[r].join.rjust(8,'0')}"
            if r<@texto_c.length-1
                print ", "
            end
        end
        puts
        print "Texto cifrado en decimal: "
        for r in (0..@texto_c.length-1)
            print "#{@texto_c[r].join.to_i(2)}"
            if r<@texto_c.length-1
                print ", "
            end
        end
        puts
    end
    
    def semilla=(s)
		for i in (0..s.length-1)
            @semilla.push(s[i].to_i)
        end
	end
    
    def texto=(t)
		for i in (0..t.length-1)
            @texto.push(t[i].to_i)
        end
	end
    
end

@test=Rc4.new

loop do
	puts "PRACTICA: CIFRADO DE RC4"
	puts "1: Cifrar"
	puts "2: Salir"
	print "Introduzca una opcion: "
	opcion = gets.chomp
	case opcion
		when '1'
            system "clear"
			print "Introduzca la semilla de clave: "
            semilla=gets.chomp.split(',')
            while semilla.empty?
				system "clear"
                puts "No se ha introducido semilla de clave".red
				puts
				print "Introduza la semilla de clave: "
				semilla=gets.chomp.split(',')
			end
            @test.semilla=semilla
            print "Introduzca el texto original: "
            texto=gets.chomp.split(',')
            while texto.empty?
				system "clear"
                puts "No se ha introducido texto original".red
				puts
				print "Introduza el texto original: "
				texto=gets.chomp.split(',')
			end
            puts
            @test.texto=texto
            @test.inicializacion
            @test.cifrado
            @test.reset
            puts
		when '2'
			system "clear"
			break
        else
            system "clear"
            puts "La opción introducida es incorrecta".red
            puts
	end
end
