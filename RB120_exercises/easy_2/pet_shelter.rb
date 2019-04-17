class Owner
  attr_reader :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def number_of_pets
    pets.size
  end
end

class Pet
  attr_reader :animal

  def initialize(animal, name)
    @animal = animal
    @name = name
  end

  def to_s
    "a #{@animal} named #{@name}"
  end
end

class Shelter
  attr_reader :owners, :unadopted

  def initialize
    @owners = []
    @unadopted = []
  end

  def adopt(owner, pet)
    owners << owner if !owners.include?(owner)
    owner.pets << pet
    unadopted.delete(pet)
  end

  def print_adoptions
    owners.each do |owner|
      puts "#{owner.name} has adopted following pets:"
      puts owner.pets
      puts ''
    end
  end

  def print_to_adoption
    puts "The Animal Shelter has the following unadopted pets:"
    puts unadopted
  end
end

pets = [
butterscotch = Pet.new('cat', 'Butterscotch'),
pudding      = Pet.new('cat', 'Pudding'),
darwin       = Pet.new('bearded dragon', 'Darwin'),
kennedy      = Pet.new('dog', 'Kennedy'),
sweetie      = Pet.new('parakeet', 'Sweetie Pie'),
molly        = Pet.new('dog', 'Molly'),
chester      = Pet.new('fish', 'Chester'),
asta         = Pet.new('dog', 'Asta'),
laddie       = Pet.new('dog', 'Laddie'),
fluffy       = Pet.new('cat', 'Fluffy'),
kat          = Pet.new('cat', 'Kat'),
ben          = Pet.new('cat', 'Ben'),
chatterbox   = Pet.new('parakeet', 'Chatterbox'),
bluebell     = Pet.new('parakeet', 'Bluebell')
]

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new

pets.each {|pet| shelter.unadopted << pet}
puts "The Animal Shelter has #{shelter.unadopted.size} unadopted pets"
shelter.print_to_adoption
puts''
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)

shelter.print_adoptions

puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts ''
shelter.print_to_adoption
puts ''
puts "The Animal shelter has #{shelter.unadopted.size} unadopted pets"
