class Rc4
	
	attr_reader :S, :semilla, :texto, :K
	
	def initialize
		@S=(0..255).to_a
        @semilla=[]
        @texto=[]
        @K=[]
	end
    
    def inicializacion
        for i in (0..@S.length-1)
            @K.push(semilla[i%semilla.length])
		end
        j=0
        for i in (0..@S.length-1)
            j=(j+@S[i]+@K[i])%@S.length
            puts "#{j} #{i}"
            @S[i],@S[j]=@S[j],@S[i]
		end
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
