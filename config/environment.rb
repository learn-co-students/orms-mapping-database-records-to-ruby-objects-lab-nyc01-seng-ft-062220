require 'pry'
require 'sqlite3'
require_relative '../lib/student'

DB = {:conn => SQLite3::Database.new("db/students.db")}
st=Student.new

sy=Student.new 

sy.id=6 
sy.name="Yuli"
sy.grade=11
sy.save
st.id=1 
st.name="p" 
st.grade=7
st.save



binding.pry 
kk