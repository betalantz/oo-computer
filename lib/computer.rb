require 'pry'

class Computer

    def self.all # not in deliverables, but useful for testing
        @@all
    end

    def self.brands
        @@all.map(&:brand).uniq # using proc notation as shorthand to replace block
    end

    def self.models
        @@all.map(&:model).uniq
    end

    def self.largest_memory
        # @@all.sort_by(&:memory_GB).last
        # @@all.max_by {|computer| computer.memory_GB }
        @@all.max_by(&:memory_GB)
    end

    @@all = []

    attr_reader :brand, :model, :storage_free
    attr_accessor :memory_GB

    def initialize(brand, model)
        @brand = brand
        @model = model
        @memory_GB = 8
        @storage_free = 1000
        @@all << self
    end

    def set_storage_free=(value)
        self.storage_free= value.clamp(0..1000) # uses private writer #storage_free=
        # @storage_free= value.clamp(0..1000) # this is also valid? What are possible advantages of using a method to access a property rather than accessing it directly?
    end

    def upgrade_memory(ram)
        self.memory_GB += ram[:size]
    end 

    def disk_full?(file_size)
        @storage_free < file_size
    end

    def save_file(file)
        if disk_full?(file[:size])
            "There is not enough space on disk to save #{file[:name]}."
        else
            self.storage_free -= file[:size]
            "#{file[:name]} has been saved!"
        end
    end
    
    def delete_file(file)
        self.storage_free += file[:size]
        "#{file[:name]} has been deleted!"
    end

    def spec
        "Current memory installed: #{@memory_GB}GB \n current storage free: #{@storage_free}GB"
    end

    private

    attr_writer :storage_free # this is not necessary for the solution, but I wanted to show
                              # this as a use case for attr_writer
    

end

acer = Computer.new("Acer", "THX1138")
acer.upgrade_memory({model: "samsung", size: 8})
puts acer.disk_full?(1100)
puts acer.spec
mbp = Computer.new("Apple", "Macbook Pro")
mair = Computer.new("Apple", "Macbook Air")

binding.pry
0