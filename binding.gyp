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
           ]
         }
        ]
      ],
      'include_dirs': [
        '/usr/include/glib-2.0',
        '/usr/include/libgtop-2.0',
        '/usr/lib/x86_64-linux-gnu/glib-2.0/include',
        '<!(node -e "require(\'nan\')")'
      ]
    }
  ]
}
