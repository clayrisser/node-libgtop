{
  'targets': [
    {
      'target_name': 'gtop',
      'dependencies' : [
        './deps/libgtop.gyp:libgtop'
      ],
      'libraries': [
        '<!@(pkg-config --libs glib-2.0)'
      ],
      'cflags': [
        '<!@(pkg-config --cflags glib-2.0)',
      ],
      'include_dirs': [
        '<!(node -e "require(\'nan\')")'
      ],
      'sources': [
        'clib/main.cc'
      ]
    }
  ]
}
