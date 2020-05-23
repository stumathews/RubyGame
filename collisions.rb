module Collisions
class Collision_Box
  attr_reader :x,:y,:w,:h,:a,:vectors
  attr_writer :w,:h
  def initialize(x,y,w,h,a=0)
    @x,@y,@w,@h,@a=x,y,w,h,(180-a)
    set_vectors
  end
    
  def collides?(col)
    return if col==self
    
    if col.class==Collision_Box
      4.times{|i|
        if i==0
          axisx=@vectors[2]-@vectors[0]
          axisy=@vectors[3]-@vectors[1]
        elsif i==1
          axisx=@vectors[2]-@vectors[4]
          axisy=@vectors[3]-@vectors[5]
        elsif i==2
          axisx=col.vectors[0]-col.vectors[6]
          axisy=col.vectors[1]-col.vectors[7]
        elsif i==3
          axisx=col.vectors[0]-col.vectors[2]
          axisy=col.vectors[1]-col.vectors[3]
        end
        
        values1=[]
        values2=[]
        4.times{|p|
        values1 << ((@vectors[p*2] * axisx + @vectors[p*2+1] * axisy) / (axisx ** 2 + axisy ** 2)) * axisx ** 2 + ((@vectors[p*2] * axisx + @vectors[p*2+1] * axisy) / (axisx ** 2 + axisy ** 2)) * axisy ** 2
        values2 << ((col.vectors[p*2] * axisx + col.vectors[p*2+1] * axisy) / (axisx ** 2 + axisy ** 2))* axisx ** 2 + ((col.vectors[p*2] * axisx + col.vectors[p*2+1] * axisy) / (axisx ** 2 + axisy ** 2))* axisy ** 2
        }
        
        return if not values2.min<=values1.max && values2.max>=values1.min
      }
      true
    elsif col.class== Collision_Ball
      a=Math::PI*(@a/180.0)
      x = Math.cos(a) * (col.x - @x) - Math.sin(a) * (col.y - @y) + @x
      y = Math.sin(a) * (col.x - @x) + Math.cos(a) * (col.y - @y) + @y
      
      if x < @x - @w/2
        cx = @x - @w/2
      elsif x > @x + @w/2
        cx = @x + @w/2
      else
        cx = x
      end
      
      if y < @y - @h/2
        cy = @y - @h/2
      elsif y > @y + @h/2
        cy = @y + @h/2
      else
        cy = y
      end
      
      distance(x,y,cx,cy)<col.r
    elsif col.class==Collision_Group
      col.collides?(self)
    end
  end
  
  def set(x,y,a=@a)
    @x,@y,@a=x,y,a
    set_vectors
  end
  
  def move(x=0,y=0,a=0)
    @x+=x
    @y+=y
    @a-=a
    set_vectors
  end
  
  def set_vectors
    d=Math.sqrt(@w**2+@h**2)/2
    a=Math::PI*(angle(0,0,@w,@h)/180.0)
    a1=Math::PI*(@a/180.0)
    @vectors=[@x+Math.sin(a1-a)*d, @y+Math.cos(a1-a)*d, @x+Math.sin(a1+a)*d, @y+Math.cos(a1+a)*d, @x+Math.sin(a1+Math::PI-a)*d, @y+Math.cos(a1+Math::PI-a)*d, @x+Math.sin(a1+Math::PI+a)*d, @y+Math.cos(a1+Math::PI+a)*d]
  end
end

class Collision_Ball
  attr_reader :x,:y,:r
  attr_writer :r
  def initialize(x,y,r)
    @x,@y,@r=x,y,r
  end
  
  def collides?(col)
    return if col==self
    if col.class==Collision_Box
      a=Math::PI*(col.a/180.0)
      x = Math.cos(a) * (@x - col.x) - Math.sin(a) * (@y - col.y) + col.x
      y = Math.sin(a) * (@x - col.x) + Math.cos(a) * (@y - col.y) + col.y
      
      if x < col.x - col.w/2
        cx = col.x - col.w/2
      elsif x > col.x + col.w/2
        cx = col.x + col.w/2
      else
        cx = x
      end
      
      if y < col.y - col.h/2
        cy = col.y - col.h/2
      elsif y > col.y + col.h/2
        cy = col.y + col.h/2
      else
        cy = y
      end
      
      distance(x,y,cx,cy)<@r
    elsif col.class== Collision_Ball
      distance(@x,@y,col.x,col.y)<@r+col.r
    elsif col.class==Collision_Group
      col.collides?(self)
    end
  end
  
  def set(x,y)
    @x,@y=x,y
  end
  
  def move(x=0,y=0)
    @x+=x
    @y+=y
  end
end

class Collision_Group
  attr_reader :x,:y,:a,:c
  def initialize(x,y,a,*c)
    @x,@y,@a,@c=x,y,(180-a),c
  end
  
  def collides?(col)
    return if col==self
    if col.class==Collision_Group
      return true if @c.find{|c| col.find{|c2| c2.collides?(c)}}
    else
      return true if @c.find{|c| c.collides?(col)}
    end
  end
  
  def set(x,y,a=@a)
    @c.each{|c| c.class==Collision_Ball ? c.move(x-@x,y-@y) : c.move(x-@x,y-@y,a-@a)}
    @x,@y=x,y
    
    @c.each{|c| dist=distance(@x,@y,c.x,c.y) ; rot=angle(@x,@y,c.x,c.y)
      c.set(@x+offset_x(rot+(a-@a),dist),@y+offset_y(rot+(a-@a),dist))
    }
    @a=a
  end
  
  def move(x=0,y=0,a=0)
    @c.each{|c| c.class==Collision_Ball ? c.move(x,y) : c.move(x,y,a)}
    @x+=x
    @y+=y
    @a+=a
    
    @c.each{|c| dist=distance(@x,@y,c.x,c.y) ; rot=angle(@x,@y,c.x,c.y)
      c.set(@x+offset_x(rot+a,dist),@y+offset_y(rot+a,dist))}
  end
end
end

