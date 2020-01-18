{
  'targets': [
    {
      'target_name': 'gtop',
      'sources': [
        'clib/main.cc'
      ],
      'conditions': [
        ['OS=="linux"',
         {
           'libraries': [
             '<!@(pkg-config --libs libgtop-2.0)'
           ],
           'cflags': [
             '<!@(pkg-config --cflags libgtop-2.0)',
           ]
         }
        ]
      ],
      'include_dirs': [
        '<!(node -e "require(\'nan\')")'
      ]
    }
  ]
}
