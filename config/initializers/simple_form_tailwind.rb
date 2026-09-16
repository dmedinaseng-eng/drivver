# frozen_string_literal: true

SimpleForm.setup do |config|
  config.browser_validations = false
  config.button_class = "w-full py-3.5 px-6 bg-[#1C5686] hover:bg-blue-800 text-white font-bold rounded-xl transition-all duration-200 text-sm uppercase tracking-wide cursor-pointer text-center border-0 shadow-md active:scale-[0.99] outline-none"

  config.wrappers :default, class: "mb-4 flex flex-col" do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.use :label, class: "block text-xs font-semibold text-gray-700 dark:text-gray-300 mb-1.5 tracking-tight"

    b.wrapper class: "relative w-full" do |ba|
      ba.use :input, class: "w-full p-3 bg-white dark:bg-[#0A0A0A] border border-gray-200 dark:border-gray-800 rounded-xl text-gray-900 dark:text-white text-sm placeholder-gray-400 dark:placeholder-gray-600 focus:ring-2 focus:ring-[#1C5686] focus:border-transparent outline-none transition-all duration-200 shadow-none",
                     error_class: "border-[#EF4444] focus:ring-[#EF4444]",
                     valid_class: "border-[#10B981]"
    end

    b.use :error, wrap_with: { tag: "p", class: "mt-1.5 text-xs text-[#EF4444] font-medium" }
    b.use :hint, wrap_with: { tag: "p", class: "mt-1 text-xs text-gray-400 dark:text-gray-500" }
  end

  config.wrappers :text, class: "mb-4 flex flex-col" do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.use :label, class: "block text-xs font-semibold text-gray-700 dark:text-gray-300 mb-1.5 tracking-tight"

    b.wrapper class: "relative w-full" do |ba|
      ba.use :input, class: "w-full p-3 bg-white dark:bg-[#0A0A0A] border border-gray-200 dark:border-gray-800 rounded-xl text-gray-900 dark:text-white text-sm placeholder-gray-400 dark:placeholder-gray-600 focus:ring-2 focus:ring-[#1C5686] focus:border-transparent outline-none transition-all duration-200 resize-none shadow-none",
                     error_class: "border-[#EF4444] focus:ring-[#EF4444]"
    end

    b.use :error, wrap_with: { tag: "p", class: "mt-1.5 text-xs text-[#EF4444] font-medium" }
    b.use :hint, wrap_with: { tag: "p", class: "mt-1 text-xs text-gray-400 dark:text-gray-500" }
  end

  config.wrappers :select, class: "mb-4 flex flex-col" do |b|
    b.use :html5
    b.use :label, class: "block text-xs font-semibold text-gray-700 dark:text-gray-300 mb-1.5 tracking-tight"

    b.wrapper class: "relative w-full" do |ba|
      ba.use :input, class: 'w-full p-3 bg-white dark:bg-[#0A0A0A] border border-gray-200 dark:border-gray-800 rounded-xl text-gray-900 dark:text-white text-sm focus:ring-2 focus:ring-[#1C5686] focus:border-transparent outline-none transition-all duration-200 appearance-none bg-[url("data:image/svg+xml;charset=utf-8,%3Csvg%20xmlns%3D%27http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%27%20fill%3D%27none%27%20viewBox%3D%270%200%2020%2020%27%20stroke%3D%27%236B7280%27%3E%3Cpath%20stroke-linecap%3D%27round%27%20stroke-linejoin%3D%27round%27%20stroke-width%3D%271.5%27%20d%3D%27M6%208l4%204%204-4%27%2F%3E%3C%2Fsvg%3E")] bg-[length:1.25em_1.25em] bg-[right_0.75rem_center] bg-no-repeat pr-9 shadow-none',
                     error_class: "border-[#EF4444] focus:ring-[#EF4444]"
    end

    b.use :error, wrap_with: { tag: "p", class: "mt-1.5 text-xs text-[#EF4444] font-medium" }
    b.use :hint, wrap_with: { tag: "p", class: "mt-1 text-xs text-gray-400 dark:text-gray-500" }
  end

  config.wrappers :boolean, class: "mb-4 flex items-start" do |b|
    b.use :html5
    b.optional :readonly

    b.wrapper class: "flex items-center h-5 mt-0.5" do |ba|
      ba.use :input, class: "w-4 h-4 text-[#1C5686] bg-white dark:bg-[#0A0A0A] border border-gray-300 dark:border-gray-700 rounded focus:ring-[#1C5686] focus:ring-2 cursor-pointer shadow-none"
    end

    b.wrapper class: "ml-3 text-xs" do |bb|
      bb.use :label, class: "font-medium text-gray-600 dark:text-gray-300 cursor-pointer select-none"
      bb.use :hint, wrap_with: { tag: "p", class: "text-xs text-gray-400 dark:text-gray-500" }
      bb.use :error, wrap_with: { tag: "p", class: "mt-1 text-xs text-[#EF4444] font-medium" }
    end
  end

  config.wrappers :file, class: "mb-4 flex flex-col" do |b|
    b.use :html5
    b.use :label, class: "block text-xs font-semibold text-gray-700 dark:text-gray-300 mb-1.5 tracking-tight"

    b.wrapper class: "relative w-full" do |ba|
      ba.use :input, class: "w-full p-2 bg-white dark:bg-[#0A0A0A] border border-gray-200 dark:border-gray-800 rounded-xl text-xs text-gray-900 dark:text-gray-300 file:mr-3 file:py-1.5 file:px-3 file:rounded-lg file:border-0 file:text-xs file:font-semibold file:bg-[#1C5686] file:text-white hover:file:bg-blue-800 cursor-pointer focus:outline-none shadow-none",
                     error_class: "border-[#EF4444]"
    end

    b.use :error, wrap_with: { tag: "p", class: "mt-1.5 text-xs text-[#EF4444] font-medium" }
    b.use :hint, wrap_with: { tag: "p", class: "mt-1 text-xs text-gray-400 dark:text-gray-500" }
  end

  config.wrapper_mappings = { select: :select, boolean: :boolean, text: :text, file: :file }
  config.label_text = lambda { |label, required, _| required ? "#{label} <span class='text-[#EF4444] font-bold ml-0.5'>*</span>".html_safe : label }
  config.default_wrapper = :default
  config.boolean_style = :nested
  config.error_notification_class = "p-3.5 mb-5 text-xs font-semibold bg-[#EF4444] text-white rounded-xl shadow-none"
end
