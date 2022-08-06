# flutter_bloc_temp

A new Flutter Bloc Template project.
## Project Structure

In `/domain`

    - feature specific `entities`, `repository`, `use_cases`

In `/presentaion/features`

    - cubit can be feature specific
    - widgets can be feature specific
    - pages can be feature specific

## Packages
### widgets_lib 
    - should contain only common widgets 
    - should not contain state mangement code in this package
