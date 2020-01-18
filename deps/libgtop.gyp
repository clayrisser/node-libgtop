{
  'targets': [
    {
      'target_name': 'libgtop',
      'type' : 'static_library',
      'direct_dependent_settings': {
        'include_dirs': [
          '/usr/include/glib-2.0',
          '/usr/lib/x86_64-linux-gnu/glib-2.0/include',
          'libgtop',
          'libgtop/include',
          'libgtop/lib',
          'libgtop/sysdeps/common',
          'libgtop/sysdeps/linux'
        ]
      },
      'include_dirs': [
        '/usr/include/glib-2.0',
        '/usr/lib/x86_64-linux-gnu/glib-2.0/include',
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
      ]
    }
  ]
}
