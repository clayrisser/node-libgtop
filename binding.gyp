{
  'targets': [
    {
      'target_name': 'gtop',
      'include_dirs': [
        '/usr/include/glib-2.0',
        '/usr/lib/x86_64-linux-gnu/glib-2.0/include',
        '<!(node -e "require(\'nan\')")',
        '<(module_path)/../../deps/libgtop',
        '<(module_path)/../../deps/libgtop/_build',
        '<(module_path)/../../deps/libgtop/include',
        '<(module_path)/../../deps/libgtop/sysdeps/linux'
      ],
      'sources': [
        'clib/main.cc'
      ],
      'libraries': [
        '-lglib-2.0',
        '<(module_path)/../../deps/libgtop/_build/lib/.libs/libgtop-2.0.a'
      ]
    }
  ]
}
