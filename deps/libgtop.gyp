{
  'targets': [
    {
      'target_name': 'libgtop',
      'dependencies' : [
        'glib.gyp:glib'
      ],
      'type' : 'static_library',
      'direct_dependent_settings': {
        'include_dirs': [
          'libgtop',
          'libgtop/include',
          'libgtop/lib',
          'libgtop/sysdeps/common',
          'libgtop/sysdeps/linux'
        ]
      },
      'include_dirs': [
        'libgtop',
        'libgtop/include',
        'libgtop/lib',
        'libgtop/sysdeps/common',
        'libgtop/sysdeps/linux'
      ],
      'sources' : [
        '<!@(ls -1 libgtop/lib/*.c)',
        '<!@(ls -1 libgtop/sysdeps/common/*.c)',
        '<!@(ls -1 libgtop/sysdeps/linux/*.c)'
      ],
      'libraries': [
        '<!@(ls -1 glib/build/glib/*.so)'
      ]
    }
  ]
}
