enum ProfilerFormat {
    s = 1000000,
    ms = 1000,
    us = 1
}

function Profiler() constructor {
    time_taken = 0;
    total_time_taken = 0;
    longest_time_taken = 0;
    
    start_time = 0;
    end_time = 0;
    measurement_count = 0;
    is_ticking = false;
    
    static Start = function() {
        if (!is_ticking) {
            start_time = get_timer();
            is_ticking = true;
        }
    }
    
    static End = function() {
        if (is_ticking) {
            end_time = get_timer();
            time_taken = end_time - start_time;
            
            total_time_taken += time_taken;
            measurement_count++;
            
            if (time_taken > longest_time_taken) {
                longest_time_taken = time_taken;
            }   
            is_ticking = false;
        }
    }
        
    static Reset = function() {   
        time_taken = 0;
        total_time_taken = 0;
        longest_time_taken = 0;
    
        start_time = 0;
        end_time = 0;
        measurement_count = 0;
        is_ticking = false;
    }
    
    static GetTime = function(profiler_format_) {
        return time_taken / profiler_format_;
    }
    
    static GetAverageTime = function(profiler_format_) {
        if (measurement_count == 0) {
            return 0;
        }
        
        return total_time_taken / (profiler_format_ * measurement_count);
    }
    
    static GetLongestTime = function(profiler_format_) {
        return longest_time_taken / profiler_format_;
    }
    
    static toString = function() {
        return "Time: " + string(GetTime(ProfilerFormat.ms)) + " ms";
    }
}