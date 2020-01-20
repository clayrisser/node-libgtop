{
  'targets': [
    {
      'target_name': 'gtop',
      'include_dirs': [
        '<!(node -e "require(\'nan\')")',
        '<(module_path)/../../deps/glib',
        '<(module_path)/../../deps/glib/build',
        '<(module_path)/../../deps/glib/build/glib',
        '<(module_path)/../../deps/glib/glib',
        '<(module_path)/../../deps/libgtop',
        '<(module_path)/../../deps/libgtop/_build',
        '<(module_path)/../../deps/libgtop/include',
        '<(module_path)/../../deps/libgtop/sysdeps/linux'
      ],
      'libraries': [
        '<(module_path)/../../deps/glib/build/glib/libglib-2.0.a',
        '<(module_path)/../../deps/libgtop/_build/lib/.libs/libgtop-2.0.a'
      ],
      'sources': [
        'clib/main.cc'
      ]
    }
  ]
}
