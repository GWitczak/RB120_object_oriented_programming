class Student

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(student)
    grade > student.grade
  end

  protected
  def grade
    @grade
  end

end

joe = Student.new('Joe', 4)
bob = Student.new('Bob', 6)

p joe.better_grade_than?(bob)
p bob.better_grade_than?(joe)

p joe.grade