require './item.rb'

class List
  attr_accessor :label

  def initialize(label)
    @label = label
    @items = []
  end

  def add_item(title, deadline, description = '')
    return false unless Item.valid_date?(deadline)

    @items << Item.new(title, deadline, description)

    true
  end

  def size
    @items.length
  end

  def valid_index?(index)
    return false if index > size - 1 || index < 0

    true
  end

  def swap(index1, index2)
    return false if !valid_index?(index1) || !valid_index?(index2)

    @items[index1], @items[index2] = @items[index2], @items[index1]
    true
  end

  def [](index)
    return nil unless valid_index?(index)

    @items[index]
  end

  def priority
    @items[0]
  end

  def print
    puts '------------------------------------'
    puts label.ljust(20)
    puts '------------------------------------'
    @items.each_with_index do |item, idx|
      puts "#{idx} | #{item.title} | #{item.deadline}"
    end
    nil
  end

  def print_full_item(index)
    puts '------------------------------------'
    item = @items[index]
    puts "#{item.title}                #{item.deadline}"
    puts "#{item.description}"
    puts '------------------------------------'
  end

  def print_priority
    puts '------------------------------------'
    item = @items[0]
    puts "#{item.title}                #{item.deadline}"
    puts "#{item.description}"
    puts '------------------------------------'
  end

  def up(index, amount)
    return false unless valid_index?(index)

    while amount > 0 && index != 0
      swap(index, index - 1)
      index -= 1
      amount -= 1
    end
    true
  end

  def down(index, amount = 1)
    return false unless valid_index?(index)

    while amount > 0 && index != size - 1
      swap(index, index + 1)
      index += 1
      amount -= 1
    end
    true
  end

  def sort_by_date!
    @items.sort_by! { |item| item.deadline  }
  end
end