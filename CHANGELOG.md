Changelog
=========

1.0.3
-----

* `print` has been renamed to `to_s` to follow ruby convention
* `row`, `column` and `box` methods have all been prepended with "sudoku_" to avoid overwriting other code
* Sudokude will now raise a TypeError if anything other than an array is passed into `Sudokude::Sudoku#new`
* added a changelog