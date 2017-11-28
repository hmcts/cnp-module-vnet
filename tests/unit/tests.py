import terraform_validate
import unittest
import os
import sys


class TestWebAppResources(unittest.TestCase):

    def setUp(self):
        """Tell the module where to find your terraform
        configuration folder
        """
        self.path = os.path.join(os.path.dirname(os.path.realpath(__file__)),
                                 "../../")
        self.v = terraform_validate.Validator(self.path)


if __name__ == '__main__':
    suite = unittest.TestLoader().loadTestsFromTestCase(TestWebAppResources)
    result = unittest.TextTestRunner(verbosity=1).run(suite)
    sys.exit(not result.wasSuccessful())
