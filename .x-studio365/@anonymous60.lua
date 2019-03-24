            
        function Euler(x, y, z)
            x = x * 0.0087266462599716
            y = y * 0.0087266462599716
            z = z * 0.0087266462599716

            local sinX = math.sin(x)
            local cosX = math.cos(x)
            local sinY = math.sin(y)
            local cosY = math.cos(y)
            local sinZ = math.sin(z)
            local cosZ = math.cos(z)

            local w = cosY * cosX * cosZ + sinY * sinX * sinZ
            x = cosY* sinX * cosZ + sinY* cosX * sinZ
            y = sinY * cosX * cosZ - cosY * sinX * sinZ
            z = cosY* cosX * sinZ - sinY* sinX * cosZ

            return {x = x, y = y, z= z, w = w}
        end

        function Slerp(q1, q2, t)
            local x1, y1, z1, w1 = q1.x, q1.y, q1.z, q1.w
            local x2,y2,z2,w2 = q2.x, q2.y, q2.z, q2.w
            local dot = x1* x2 + y1* y2 + z1* z2 + w1* w2

            if dot< 0 then
                dot = -dot
                x2, y2, z2, w2 = -x2, -y2, -z2, -w2
            end

            if dot< 0.95 then
                local sin = math.sin
                local angle = math.acos(dot)
                local invSinAngle = 1 / sin(angle)
                local t1 = sin((1 - t) * angle) * invSinAngle
                local t2 = sin(t * angle) * invSinAngle
                return {x = x1* t1 + x2* t2, y = y1 * t1 + y2 * t2, z = z1 * t1 + z2 * t2, w = w1 * t1 + w2 * t2}
            else
                x1 = x1 + t* (x2 - x1)
                y1 = y1 + t* (y2 - y1)                
                z1 = z1 + t* (z2 - z1)                
                w1 = w1 + t* (w2 - w1)
                dot = x1* x1 + y1* y1 + z1* z1 + w1* w1

                return {x = x1 / dot, y = y1 / dot, z = z1 / dot, w = w1 / dot}
            end
        end

        if jit then
    	    if jit.status() then                
                for i=1,10000 do
                    local q1 = Euler(i, i, i)
                    Slerp({ x = 0, y = 0, z = 0, w = 1}, q1, 0.5)
                end                
            end	                   
        end