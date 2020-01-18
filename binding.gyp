{
  'targets': [
    {
      'target_name': 'gtop',
      'dependencies' : [
        'deps/libgtop.gyp:libgtop',
        'deps/glib.gyp:glib'
      ],
      'include_dirs': [
        '<!(node -e "require(\'nan\')")'
      ],
      'sources': [
        'clib/main.cc'
      ],
      'libraries': [
        '<!@(ls -1 /home/codejamninja/Projects/node-libgtop/deps/glib/build/glib/*.so)'
      ]
    }
  ]
}
