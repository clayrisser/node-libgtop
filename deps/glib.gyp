{
  'targets': [
    {
      'target_name': 'glib',
      'type' : 'static_library',
      'direct_dependent_settings': {
        'include_dirs': [
          'glib',
          'glib/glib',
          'glib/build',
          'glib/build/glib'
        ]
      },
      'include_dirs': [
        'glib',
        'glib/glib',
        'glib/build',
        'glib/build/glib'
      ],
      'sources' : [
        'glib/glib/glib.h'
      ]
    }
  ]
}
