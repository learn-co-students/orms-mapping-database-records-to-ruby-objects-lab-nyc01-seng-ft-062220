class Student
  attr_accessor :id, :name, :grade

  def self.new_from_db(row)
    new_student = self.new
    new_student.id = row[0]
    new_student.name = row[1]
    new_student.grade = row[2] 

    new_student


  end

  def self.all
    # retrieve all the rows from the "Students" database
    # remember each row should be a new instance of the Student class
    sql = <<-SQL
   SELECT * 
   FROM students;
   SQL

   DB[:conn].execute(sql).map {|row| self.new_from_db(row)}
  end




  def self.find_by_name(name)
   sql = <<-SQL
   SELECT * 
   FROM students
   WHERE name = ?
   LIMIT 1;
   SQL

   DB[:conn].execute(sql,name).map {|row| self.new_from_db(row)}.first
  end
  
  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end
  
  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end


  def self.all_students_in_grade_9
      all_students_in_grade_X(9)
  end
 
  def self.first_X_students_in_grade_10(no_of_students)
    self.first_X_students_in_grade_X(no_of_students,10)
  end

  def self.first_student_in_grade_10
    self.first_X_students_in_grade_X(1,10).first
  end

  def self.students_below_12th_grade
    sql = <<-SQL
    SELECT * 
    FROM students
    WHERE grade < 12
    LIMIT 1;
    SQL

    DB[:conn].execute(sql).map{|row| new_from_db(row)}
  end



  #helpers
  def self.all_students_in_grade_X(integer)
    sql = <<-SQL
    SELECT * 
    FROM students
    WHERE grade = ?;
    SQL

    DB[:conn].execute(sql,integer)

  end

 private
  def self.first_X_students_in_grade_X(no_of_students,grade)
    sql = <<-SQL
    SELECT *
    FROM students
    WHERE grade = ?
    LIMIT ?;
    SQL

    DB[:conn].execute(sql,grade,no_of_students).map{|row| new_from_db(row)}
  end








end
