# Copyright (c) 2020, NVIDIA CORPORATION.

# cython: profile=False
# distutils: language = c++
# cython: embedsignature = True
# cython: language_level = 3

from cudf._libxx.lib cimport *
from cudf._libxx.io.types cimport *

from libcpp.string cimport string
from libcpp.vector cimport vector
from cudf._libxx.io.types cimport *


cdef extern from "cudf/io/functions.hpp" \
        namespace "cudf::experimental::io" nogil:

    cdef cppclass read_avro_args:
        source_info source
        vector[string] columns
        size_t skip_rows
        size_t num_rows

    cdef table_with_metadata read_avro(read_avro_args &args) except +

    cdef cppclass read_json_args:
        source_info source
        bool lines
        compression_type compression
        vector[string] dtype
        bool dayfirst
        size_t byte_range_offset
        size_t byte_range_size

        read_json_args() except +

        read_json_args(source_info src) except +

    cdef table_with_metadata read_json(read_json_args &args) except +

    cdef cppclass read_csv_args:
        source_info source

        # Reader settings
        compression_type compression
        size_t byte_range_offset
        size_t byte_range_size
        vector[string] names
        string prefix
        bool mangle_dupe_cols

        # Filter settings
        vector[string] use_cols_names
        vector[int] use_col_indexes
        size_t nrows
        size_t skiprows
        size_t skipfooter
        size_t header

        # Parsing settings
        char lineterminator
        char delimiter
        char thousands
        char decimal
        char comment
        bool windowslinetermination
        bool delim_whitespace
        bool skipinitialspace
        bool skip_blank_lines
        quote_style quoting
        char quotechar
        bool doublequote
        vector[string] infer_date_names
        vector[int] infer_date_indexes

        # Conversion settings
        vector[string] dtype
        vector[string] true_values
        vector[string] false_values
        vector[string] na_values
        bool keep_default_na
        bool na_filter
        bool dayfirst

    cdef table_with_metadata read_csv(read_csv_args &args) except +

    cdef cppclass read_orc_args:
        source_info source
        vector[string] columns
        size_t stripe
        size_t skip_rows
        size_t num_rows
        bool use_index
        bool use_np_dtypes
        bool decimals_as_float
        int forced_decimals_scale

    cdef table_with_metadata read_orc(read_orc_args &args) except +

    cdef cppclass write_parquet_args:
        sink_info sink
        compression_type compression
        statistics_freq stats_level
        table_view table
        const table_metadata *metadata

        write_parquet_args() except +
        write_parquet_args(sink_info sink_,
                           table_view table_,
                           table_metadata *table_metadata_,
                           compression_type compression_,
                           statistics_freq stats_lvl_) except +

    cdef void write_parquet(write_parquet_args args)
