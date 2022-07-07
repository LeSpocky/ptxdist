cmake_minimum_required(VERSION 3.1)
project(@name@)

add_executable(@name@
	@name@.c
)

install(TARGETS @name@ RUNTIME DESTINATION bin)
