# -*- coding: utf-8 -*-

import unittest
from HtmlTestRunner import HTMLTestRunner
from apps.utils.unitTest.test_mathfunc import TestMathFunc

if __name__ == '__main__':
    suite = unittest.TestSuite()

    # tests = [TestMathFunc("test_add"), TestMathFunc("test_minus"), TestMathFunc("test_divide")]
    # suite.addTests(tests)
    suite.addTests(unittest.TestLoader().loadTestsFromTestCase(TestMathFunc))

    # runner = unittest.TextTestRunner(verbosity=2)
    # runner.run(suite)


    runner = HTMLTestRunner(output='example_suite')

    runner.run(suite)

