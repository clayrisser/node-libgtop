{
  'targets': [
    {
      'target_name': 'nodejs-ps',
      'sources': [
        'clib/main.cc'
      ],
      'conditions': [
        ['OS=="linux"',
         {
           'libraries': [
             '<!@(pkg-config --libs libgtop-2.0)'
           ],
           'ldflags': [
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
