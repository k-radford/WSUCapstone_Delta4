import setuptools

setuptools.setup(
    name='deltapersistence',
    version='0.9',
    author='Joshua Mirth',
    author_email='joshua.mirth@gmail.com',
    description='Persistent homology tools for NSF-DELTA.',
    url='https://gitlab.com/jrmirth/deltapersistence',
    project_urls={
        "Documentation": "https://jrmirth.gitlab.io/deltapersistence/",
        "Delta Homepage": "https://delta-topology.org/",
    },
    license='MIT',
    packages=setuptools.find_packages(),
    scripts=['bin/persistence_script.py'],
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    python_requires='>=3.6',
    install_requires=['numpy'],
    zip_safe=False
)
